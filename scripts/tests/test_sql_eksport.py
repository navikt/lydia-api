from util.sql_eksport import gjør_tema_inaktivt


def test_gjør_tema_inaktivt():
    assert (
        gjør_tema_inaktivt(1)
        == "-- Gjør tema inaktivt"
        + "\n"
        + "UPDATE ia_sak_kartlegging_tema"
        + "\n"
        + "SET status = 'INAKTIV'"
        + "\n"
        + "WHERE tema_id = 1;"
        + "\n"
    )


def legg_til_ny_funksjon():
    return 0
