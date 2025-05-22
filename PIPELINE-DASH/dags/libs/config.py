PROJECT_ID   = "abstract-gizmo-441020-v4"    
DATASET      = "wdi_internet_bronze"
TABLE_RAW    = "wdi_internet_raw"

BASE_URL     = "http://api.worldbank.org/v2"
COUNTRY_CODE = "ARG"
INDICATORS = [
    "IT.NET.USER.ZS", "IT.NET.USER.FE.ZS", "IT.NET.USER.MA.ZS",
    "IT.NET.SECR", "IT.NET.SECR.P6", "IT.NET.BBND", "IT.NET.BBND.P2",
    "IT.MLT.MAIN", "IT.MLT.MAIN.P2", "IT.CEL.SETS", "IT.CEL.SETS.P2",
    "NY.GDP.PCAP.CD", "NY.GDP.PCAP.KD.ZG", "FP.CPI.TOTL",
    "SP.POP.TOTL", "SP.POP.TOTL.MA.ZS", "SP.POP.TOTL.MA.IN",
    "SP.POP.TOTL.FE.ZS", "SP.POP.TOTL.FE.IN", "SP.POP.1564.TO",
    "SP.POP.1564.TO.ZS", "SP.URB.TOTL.IN.ZS", "SP.URB.TOTL"
]
DATE_RANGE   = "1990:2024"
PER_PAGE     = 10000
SOURCE       = 2
FORMAT       = "json"