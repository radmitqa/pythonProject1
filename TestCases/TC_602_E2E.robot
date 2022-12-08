*** Settings ***
Library  RequestsLibrary
Library  JSONLibrary
Library  Collections

*** Variables ***
${base_url}  https://reqres.in
${original_email}  1@1.net
${update_email}  2@1.net

*** Test Cases ***
TC_601_End_to_End_Test_Case
    # Part 1 - POST Request
    [Tags]  Smoke
    create session  E2E  ${base_URL}
    &{body}=  create dictionary  email=${original_email}  password=Pass123
    &{header}=  create dictionary  Content-Type=application/json
    ${post_resp}=  POST REQUEST  E2E  /api/register  data=&{body}  headers=&{header}
    Log to console  ${post_resp.status_code}

    ${response_code}=  convert to string  ${post_resp.status_code}
    BuiltIn.Should Be Equal  ${response_code}  201
    Log to console  ${post_resp.content}
    Log to console  ${post_resp.json()}

    @{id_list}=  get value from json  ${post_resp.json()}  id
    ${id}=  get from list  @{id_list}  0
    Log to console  ${id}

    # Part 2 - PUT REQUEST
    &{body_1}=  create dictionary  id=${id}  email=${update_email}  password=Pass123
    ${put_resp}=  PUT ON SESSION  E2E  /api/register/@{id}  data=&{body_1}  headers=&{header}
    Log to console  ${put_resp.status_code}
    Log to console  ${put_resp.json()}

    # Part 3 - GET REQUEST
    ${get_request}=  GET REQUEST  E2E  /api/${id}
    ${json_resp}=  to json  ${get_request.content}
    @{list_email}=  get value from json  ${json_resp}  data.email
    ${actual_email}=  get from list  @{list_email}  0
    should be equal  ${actual_email}  ${update_email}

    # Part 4 - DELETE REQUEST
    ${delete_response}=  DELETE REQUEST  E2E  api/del/${id}
    ${json_delete}=  to json  ${delete_response.content}
    @{message}=  get value from json  ${json_delete}  status
    ${status_msg}=  get from list  @{message}  0
    should be equal  ${status_msg}  true

