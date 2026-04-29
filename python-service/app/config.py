from pathlib import Path

import pytoml as toml


CONFIG_PATH = Path(__file__).resolve().parent.parent / "config" / "settings.toml"


def load_message() -> str:
    with CONFIG_PATH.open("r", encoding="utf-8") as config_file:
        settings = toml.load(config_file)
    return settings["service"]["message"]
