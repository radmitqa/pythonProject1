*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_URL}  https://reqres.in

*** Test Cases ***
TC_004_Get_Request_With_Params
    [Tags]  Smoke
    create session  Get_Params  ${base_URL}
    &{param}=  create dictionary  page=2
    ${response}=  GET On Session  Get_Params  /api/users  params=&{param}
    ${actual_status_code}=  convert to string  ${response.status_code}
    BuiltIn.Should Be Equal  ${actual_status_code}  200

    ${json_response}=  to json  ${response.content}

    @{first_name_list}=  get value from json  ${json_response}  data[0].first_name
    ${first_name_user_1}=  get from list  ${first_name_list}  0
    log to console  ${first_name_user_1}
    BuiltIn.Should Be Equal  ${first_name_user_1}  Michael

    @{last_name_list}=  get value from json  ${json_response}  data[1].last_name
    ${last_name_user_2}=  get from list  ${last_name_list}  0
    log to console  ${last_name_user_2}
    BuiltIn.Should Be Equal  ${last_name_user_2}  Ferguson

    @{id_list}=  get value from json  ${json_response}  data[2].id
    ${id_user_3}=  get from list  ${id_list}  0
    log to console  ${id_user_3}
    ${actual_id}=  convert to string  ${id_user_3}
    BuiltIn.Should Be Equal  ${actual_id}  9
