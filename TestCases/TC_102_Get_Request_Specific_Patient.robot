*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://dev-n69d386hw4b698w.api.raw-labs.com
${country}  country=UK
${min_year}  minYear=1998
${max_year}  maxYear=1999
${code}  code=L53.8

${base_url1}  https://dev-n69d386hw4b698w.api.raw-labs.com/2?country=UK&minYear=2004&maxYear=2006&code=L53.8

*** Test Cases ***
TC_102_Get_Request_Specific_Data_with_base_url_1
    [Tags]  Regression
    create session  Get Specific Data  ${base_url_1}
    ${resp}=  GET On Session  Get Specific Data  ${base_url_1}
    ${actual_status_code}=  convert to string  ${resp.status_code}
    BuiltIn.Should Be Equal  ${actual_status_code}  200
    Log to console  ${resp.status_code}
    Status Should Be    OK    ${resp}

    ${json_response}=  to json  ${resp.content}

    # Validate city value from first patient
    @{my_dict_1}=  get value from json  ${json_response[0]}  city
    ${my_city_1}=  get from list  ${my_dict_1}  0
    Log to console  ${my_city_1}
    BuiltIn.Should Be Equal  ${my_city_1}  Geneva

    # Validate country value from second patient
    @{my_dict_2}=  get value from json  ${json_response[1]}  country
    ${my_city_2}=  get from list  ${my_dict_2}  0
    Log to console  ${my_city_2}
    BuiltIn.Should Be Equal  ${my_city_2}  France

    # Validate second diag_id value from diag list from third patient
    @{my_dict_3}=  get value from json  ${json_response[2]}  diagnosis
    ${diagn_1}=  get from list  ${my_dict_3}  0
    Log to console  ${diagn_1[1]}
    ${actual_diagn_id}=  get value from json  ${diagn_1[1]}  diag_id
    BuiltIn.Should Be Equal  ${actual_diagn_id[0]}  2096
    Log to console  ${actual_diagn_id[0]}

    # Validate patient_id value from fourth patient
    @{my_dict_4}=  get value from json  ${json_response[3]}  patient_id
    ${patient_id_4}=  get from list  ${my_dict_4}  0
    Log to console  ${patient_id_4}
    BuiltIn.Should Be Equal  ${patient_id_4}  P00064






#TC_103_Get_Request_Specific_Data_with_URL_Params_as_Dict
#    [Tags]  Regression
#    create session  Get Specific Data  ${base_url}
#    &{params}=  create dictionary  country=UK  minYear=1999  maxYear=2000  code=L53.9
#    ${resp}=  GET On Session  Get Specific Data  /2  params=&{params}
#    ${actual_status_code}=  convert to string  ${resp.status_code}
#    BuiltIn.Should Be Equal  ${actual_status_code}  200
#    Log to console  ${resp.status_code}
#    Status Should Be    OK    ${resp}
#    Log to console  ${resp.content}