"""Isolated Pocket Alice body bridge MCP server. Standard library only."""

import json
import subprocess
import sys
from pathlib import Path


TRANSPORT_HELPER = Path(__file__).resolve().with_name("body-transport")
REQUEST_TIMEOUT_SECONDS = 15.0
MAXIMUM_RESPONSE_BYTES = 4_096
MAXIMUM_SPEECH_CHARACTERS = 240

BODY_STATES = ["idle", "listening", "thinking", "speaking", "pulse"]
STATUS_KEYS = {"reachable", "device_type", "connection_state", "interface_version"}


TOOLS = [
    {
        "name": "alice_get_body_status",
        "description": (
            "Check whether the foreground Pocket Alice iPhone interface is reachable "
            "through its fixed Bonjour service on the local network."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {},
            "additionalProperties": False,
        },
        "annotations": {
            "readOnlyHint": True,
            "destructiveHint": False,
            "idempotentHint": True,
            "openWorldHint": True,
        },
    },
    {
        "name": "alice_set_body_state",
        "description": (
            "Set only Pocket Alice's temporary glowing-orb presentation state on the "
            "foreground iPhone app. Pulse briefly animates, then restores the prior state."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "state": {"type": "string", "enum": BODY_STATES},
            },
            "required": ["state"],
            "additionalProperties": False,
        },
        "annotations": {
            "readOnlyHint": False,
            "destructiveHint": False,
            "idempotentHint": False,
            "openWorldHint": True,
        },
    },
    {
        "name": "alice_speak",
        "description": (
            "Speak one short text through Pocket Alice's local iPhone speech synthesizer "
            "while the app is open in the foreground."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "text": {
                    "type": "string",
                    "minLength": 1,
                    "maxLength": MAXIMUM_SPEECH_CHARACTERS,
                },
            },
            "required": ["text"],
            "additionalProperties": False,
        },
        "annotations": {
            "readOnlyHint": False,
            "destructiveHint": False,
            "idempotentHint": False,
            "openWorldHint": True,
        },
    },
]


class BodyUnavailable(Exception):
    """Raised when the fixed local Bonjour service cannot be reached."""


def _tool_result(value, is_error=False):
    text = value if isinstance(value, str) else json.dumps(value, sort_keys=True)
    return {"content": [{"type": "text", "text": text}], "isError": is_error}


def _request_json(method, path, payload=None):
    body = b"" if payload is None else json.dumps(payload, separators=(",", ":")).encode("utf-8")
    try:
        result = subprocess.run(
            [str(TRANSPORT_HELPER), method, path],
            input=body,
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE,
            timeout=REQUEST_TIMEOUT_SECONDS,
            check=False,
        )
    except (OSError, subprocess.TimeoutExpired) as error:
        raise BodyUnavailable("Pocket Alice transport is unavailable or timed out") from error
    if result.returncode != 0:
        raise BodyUnavailable("Pocket Alice is not reachable on the local or peer-to-peer network")
    if len(result.stdout) > MAXIMUM_RESPONSE_BYTES:
        raise BodyUnavailable("Pocket Alice returned an oversized response")
    try:
        decoded = json.loads(result.stdout)
    except (UnicodeDecodeError, json.JSONDecodeError) as error:
        raise BodyUnavailable("Pocket Alice returned an invalid response") from error
    if not isinstance(decoded, dict):
        raise BodyUnavailable("Pocket Alice returned an unexpected response")
    return decoded


def _get_body_status():
    try:
        status = _request_json("GET", "/alice-body-status")
        if set(status) != STATUS_KEYS:
            raise BodyUnavailable("Pocket Alice returned an unexpected status shape")
        if status["reachable"] is not True:
            raise BodyUnavailable("Pocket Alice did not confirm reachability")
        if status["device_type"] != "iphone":
            raise BodyUnavailable("Pocket Alice returned an unexpected device type")
        if status["connection_state"] != "foreground_ready":
            raise BodyUnavailable("Pocket Alice is not foreground-ready")
        if status["interface_version"] != "1.0":
            raise BodyUnavailable("Pocket Alice uses an unsupported interface version")
        return status
    except BodyUnavailable:
        return {
            "reachable": False,
            "device_type": None,
            "connection_state": "not_reachable",
            "interface_version": None,
        }


def _validate_exact_arguments(arguments, key):
    if not isinstance(arguments, dict) or set(arguments) != {key}:
        raise ValueError(f"Exactly one '{key}' argument is required")
    return arguments[key]


def _call_tool(name, arguments):
    if name == "alice_get_body_status":
        if arguments != {}:
            raise ValueError("alice_get_body_status accepts no arguments")
        return _tool_result(_get_body_status())

    if name == "alice_set_body_state":
        state = _validate_exact_arguments(arguments, "state")
        if not isinstance(state, str) or state not in BODY_STATES:
            raise ValueError("state must be one of: " + ", ".join(BODY_STATES))
        try:
            result = _request_json("POST", "/alice-body-state", {"state": state})
        except BodyUnavailable as error:
            return _tool_result(str(error), is_error=True)
        if set(result) != {"success", "state"} or result != {"success": True, "state": state}:
            return _tool_result("Pocket Alice returned an unexpected state response", is_error=True)
        return _tool_result(result)

    if name == "alice_speak":
        text = _validate_exact_arguments(arguments, "text")
        if (
            not isinstance(text, str)
            or not text
            or text != text.strip()
            or len(text) > MAXIMUM_SPEECH_CHARACTERS
        ):
            raise ValueError(
                f"text must contain 1-{MAXIMUM_SPEECH_CHARACTERS} characters with no surrounding whitespace"
            )
        try:
            result = _request_json("POST", "/alice-speak", {"text": text})
        except BodyUnavailable as error:
            return _tool_result(str(error), is_error=True)
        if set(result) != {"success", "spoken"} or result != {"success": True, "spoken": True}:
            return _tool_result("Pocket Alice returned an unexpected speech response", is_error=True)
        return _tool_result(result)

    raise ValueError("Unknown tool")


def dispatch(request):
    method = request.get("method")
    params = request.get("params", {})

    if method == "initialize":
        return {
            "protocolVersion": "2024-11-05",
            "capabilities": {"tools": {}},
            "serverInfo": {"name": "alice_body_test", "version": "0.1.0"},
        }

    if method == "ping":
        return {}

    if method == "tools/list":
        return {"tools": TOOLS}

    if method == "tools/call":
        if not isinstance(params, dict):
            raise ValueError("Invalid tool call")
        return _call_tool(params.get("name"), params.get("arguments", {}))

    raise LookupError("Method not found")


def main():
    for line in sys.stdin:
        try:
            request = json.loads(line)
        except (ValueError, TypeError):
            response = {
                "jsonrpc": "2.0",
                "id": None,
                "error": {"code": -32700, "message": "Parse error"},
            }
        else:
            if not isinstance(request, dict) or request.get("jsonrpc") != "2.0":
                response = {
                    "jsonrpc": "2.0",
                    "id": None,
                    "error": {"code": -32600, "message": "Invalid request"},
                }
            elif "id" not in request:
                continue
            else:
                response = {"jsonrpc": "2.0", "id": request["id"]}
                try:
                    response["result"] = dispatch(request)
                except ValueError as error:
                    response["error"] = {"code": -32602, "message": str(error)}
                except LookupError as error:
                    response["error"] = {"code": -32601, "message": str(error)}

        sys.stdout.write(json.dumps(response) + "\n")
        sys.stdout.flush()


if __name__ == "__main__":
    main()
