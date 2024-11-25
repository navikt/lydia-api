from uuid_extensions import uuid7
from time import sleep


def generer_uuider(antall: int) -> list[str]:
    list = []
    for i in range(antall):
        uuid = generer_uuid_med_delay()
        list.append(uuid)

    return list


def generer_uuid_med_delay() -> str:
    sleep(0.01)
    return uuid7(as_type="str")