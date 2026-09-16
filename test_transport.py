"""Public tests for the Pocket Alice body bridge server."""

import importlib.util
import json
import subprocess
from pathlib import Path
from unittest.mock import patch


def load_server():
    path = Path(__file__).resolve().with_name("server.py")
    spec = importlib.util.spec_from_file_location("alice_body_server", path)

    if spec is None or spec.loader is None:
        raise RuntimeError("Unable to load server.py")

    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


server = load_server()


cases = [
    (
        "alice_get_body_status",
        {},
        {
            "reachable": True,
            "device_type": "iphone",
            "connection_state": "foreground_ready",
            "interface_version": "1.0",
        },
    ),
    (
        "alice_set_body_state",
        {"state": "pulse"},
        {"success": True, "state": "pulse"},
    ),
    (
        "alice_speak",
        {"text": "Hello"},
        {"success": True, "spoken": True},
    ),
]


for name, args, response in cases:
    raw = json.dumps(response).encode()

    with patch.object(
        server.subprocess,
        "run",
        return_value=subprocess.CompletedProcess([], 0, raw, b""),
    ) as run:
        result = server._call_tool(name, args)

        assert json.loads(result["content"][0]["text"]) == response
        assert run.call_args.kwargs["timeout"] == 15


for raw in (b"[]", b"{", b"x" * 4097):
    with patch.object(
        server.subprocess,
        "run",
        return_value=subprocess.CompletedProcess([], 0, raw, b""),
    ):
        assert server._get_body_status()["reachable"] is False


for failure in (
    FileNotFoundError(),
    subprocess.TimeoutExpired("helper", 15),
):
    with patch.object(server.subprocess, "run", side_effect=failure):
        assert server._get_body_status()["reachable"] is False
        assert server._call_tool(
            "alice_speak",
            {"text": "Hello"},
        )["isError"] is True


invalid_cases = [
    ("alice_speak", {"text": " x"}),
    ("alice_speak", {"text": "x" * 241}),
    ("alice_set_body_state", {"state": "bad"}),
    ("alice_get_body_status", {"extra": 1}),
]


for name, args in invalid_cases:
    with patch.object(server.subprocess, "run") as run:
        try:
            server._call_tool(name, args)
        except ValueError:
            pass
        else:
            raise AssertionError("Expected validation failure")

        run.assert_not_called()


print(
    "PASS: three successful tool contracts; validation, transport failures, "
    "timeout, malformed-response and response-size handling"
)
