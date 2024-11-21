from pydantic import BaseModel
from main.dataklasser.Spørsmål import Spørsmål


class Undertema(BaseModel):
    id: int
    navn: str
    rekkefølge: int
    spørsmål: list[Spørsmål]
    obligatorisk: bool = False
