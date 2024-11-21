from main.util.sql_eksport import gjør_tema_inaktivt


def test_gjør_tema_inaktivt():
    assert (
        gjør_tema_inaktivt(1)
        == "UPDATE ia_sak_kartlegging_tema"
        + "\n"
        + "SET status = 'INAKTIV'"
        + "\n"
        + "WHERE tema_id = 1;"
    )
