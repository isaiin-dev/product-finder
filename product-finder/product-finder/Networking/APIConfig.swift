//
//  APIConfig.swift
//  product-finder
//
//  Created by Alejandro isai Acosta Martinez on 12/04/22.
//

import Foundation

struct APIConfig {
    struct AUTH {
        struct KEYWORDS_API {
            static let RapidAPIHost = "keywords4.p.rapidapi.com"
            static let RapidAPIKey  = "1c4637e5c2msh4648a70efd99badp1653d9jsnc733d77f2f38"
        }

        struct MELI {
            static let BearerToken  = "Bearer 6G5phwCDWyQQqyPCQYMFMFSVWNuZIKWK"
        }
    }
    
    struct CONFIG {
        struct SERVER {
            struct RAPIDAPPI {
                static let BASE_URL = "https://keywords4.p.rapidapi.com"
            }
            
            struct MELI {
                static let BASE_URL = "https://api.mercadolibre.com"
            }
        }
    }
    
    struct SPACE {
        struct RAPIDAPI {
            static let KEYWORD_SEARCH = "/"
        }
        
        struct MELI {
            static let PRODUCTS = "/products/"
        }
    }
    
    struct ENDPOINT {
        struct RAPIDAPI {
            static let SUGGESTED_KEYWORDS = "google-topLevel-10-keywords"
        }
        
        struct MELI {
            struct PRODUCTS {
                static let SEARCH = "search"
            }
        }
    }
}
