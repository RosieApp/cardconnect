
def valid_auth_request
  {
      "merchid" => "000000927996",
      "accttype" => "VISA",
      "orderid" => "AB-11-9876",
      "account" => "4111111111111111",
      "expiry" => "1212",
      "amount" => "0",
      "currency" => "USD",
      "name" => "TOM JONES",
      "address" => "123 MAIN STREET",
      "city" => "anytown",
      "region" => "NY",
      "country" => "US",
      "postal" => "55555",
      "ecomind" => "E",
      "cvv2" => "123",
      "track" => nil,
      "tokenize" => "Y"
  }
end

def valid_capture_request
  {
    "retref" => "288002073633",
    "shiptozip" => "11111-1111",
    "shipfromzip" => "99999-9999",
    "amount" => "596.00",
    "items" => [
      {
        "discamnt" => "0",
        "unitcost" => "900",
        "uom" => "CS",
        "lineno" => "1",
        "description" => "DESCRIPTION-1",
        "taxamnt" => "117",
        "quantity" => "1000",
        "upc" => "UPC-1",
        "netamnt" => "150",
        "material" => "MATERIAL-1"
      },
      {
        "discamnt" => "0",
        "unitcost" => "450",
        "uom" => "CS",
        "lineno" => "2",
        "description" => "DESCRIPTION-2",
        "taxamnt" => "117",
        "quantity" => "2000",
        "upc" => "UPC-1",
        "netamnt" => "300",
        "material" => "MATERIAL-2"
      }
    ],
    "taxamount" => "40.00",
    "merchid" => "000000927996",
    "account" => "4111111111111111",
    "ponumber" => "PO-0736332"
  }
end