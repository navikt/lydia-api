data class NæringSykefravær (
    val kvartal : Int,
    val prosent : Double,
    val muligeDagsverk : Double,
    val årstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class Næring5SifferSykefravær (
    val kvartal : Int,
    val prosent : Double,
    val muligeDagsverk : Double,
    val årstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class VirksomhetSykefravær (
    val kvartal : Int,
    val prosent : Double,
    val muligeDagsverk : Double,
    val årstall : Int,
    val antallPersoner : Double,
    val orgnr : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class LandSykefravær (
    val kvartal : Int,
    val prosent : Double,
    val muligeDagsverk : Double,
    val årstall : Int,
    val kode : String,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class SektorSykefravær (
    val kvartal : Int,
    val prosent : Double,
    val muligeDagsverk : Double,
    val årstall : Int,
    val kode : Int,
    val antallPersoner : Double,
    val kategori : String,
    val tapteDagsverk : Double,
    val maskert : Boolean
)

data class SykefraversstatistikkImportDto (
    val næringSykefravær : NæringSykefravær,
    val næring5SifferSykefravær: List<Næring5SifferSykefravær>,
    val virksomhetSykefravær : VirksomhetSykefravær,
    val landSykefravær : LandSykefravær,
    val sektorSykefravær : SektorSykefravær
)

data class Key (
    val kvartal : Int,
    val årstall : Int,
    val orgnr : String
)

data class SykefraversstatistikkKafkaMelding (
    val value : SykefraversstatistikkImportDto,
    val key : Key
)
