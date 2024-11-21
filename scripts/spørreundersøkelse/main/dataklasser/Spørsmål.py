from pydantic import BaseModel
from typing import Annotated
from pydantic import BaseModel, StringConstraints
from main.util.generer_uuider import generer_uuid_med_delay
from main.dataklasser.Svaralternativ import Svaralternativ, lagSvaralternativer


class Spørsmål(BaseModel):
    tekst: str
    id: Annotated[str, StringConstraints(min_length=36, max_length=36)] = (
        generer_uuid_med_delay()
    )
    flervalg: bool = False
    svaralternativer: list[Svaralternativ] = lagSvaralternativer(
        alternativer=[
            "Helt enig",
            "Litt enig",
            "Litt uenig",
            "Helt uenig",
            "Vet ikke",
        ]
    )
