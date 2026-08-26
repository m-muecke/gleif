# Fetch the list of registration authorities

Fetches the list of registration authorities (RA codes) recognized by
the GLEIF API. These resolve the registration authority codes that
appear in
[`lei_record_by_id()`](https://m-muecke.github.io/gleifr/reference/lei_record_by_id.md)
output to the issuing business registries.

## Usage

``` r
lei_registration_authorities()
```

## Value

A [`data.frame()`](https://rdrr.io/r/base/data.frame.html) with columns:

- **code**: The registration authority (RA) code

- **international_name**: The international name of the authority

- **local_name**: The local name of the authority, or `NA` if none

- **website**: The authority website, or `NA` if none

## Examples

``` r
# \donttest{
head(lei_registration_authorities())
#> iterating ■■■■■■■■■■■■■■■■                  50% | ETA:  1s
#> iterating ■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■  100% | ETA:  0s
#>       code
#> 1 RA000001
#> 2 RA000002
#> 3 RA000003
#> 4 RA000004
#> 5 RA000005
#> 6 RA000006
#>                                                            international_name
#> 1 Afghanistan Central Business Registry (Ministry of Commerce and Industries)
#> 2                                                                        <NA>
#> 3                                                              Trade Register
#> 4                                                        Register of Commerce
#> 5                                          Central Registry of Business Names
#> 6                                                         Commercial Registry
#>                                 local_name
#> 1                                     <NA>
#> 2                                     <NA>
#> 3                     Registre du Commerce
#> 4         Registre de Societats Mercantils
#> 5 Ficheiro Central de Denominações Sociais
#> 6                      Commercial Registry
#>                                                     website
#> 1                                   http://www.acbr.gov.af/
#> 2                               http://www.qkr.gov.al/home/
#> 3                https://sidjilcom.cnrc.dz/web/cnrc/accueil
#> 4                     http://www.comerc.ad/la-unitat-comerc
#> 5 http://www.cidadao.gov.ao/VerPrestadorServico.aspx?id=233
#> 6                         http://www.commercialregistry.ai/
# }
```
