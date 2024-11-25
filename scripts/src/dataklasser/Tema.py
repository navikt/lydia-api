from typing import Literal

from dataklasser.Undertema import Undertema


class Tema:
    def __init__(
        self,
        id: int,
        navn: Literal["Partssamarbeid", "Sykefraværsarbeid", "Arbeidsmiljø"],
        type: Literal["Behovsvurdering", "Evaluering"],
        undertemaer: list[Undertema],
    ):
        self.id = id
        self.navn = navn
        self.type = type
        self.undertemaer = undertemaer
