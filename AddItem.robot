*** Settings ***
Library    SeleniumLibrary
Resource    ${CURDIR}/Variable.resource
Suite Setup    Open Web Todolist
Suite Teardown    Close All Browsers

*** Variables ***
@{list_items}    กินข้าว    อาบน้ำ    ล้างจาน    ออกกำลังกาย    Shopping    ร้องเพลง


*** Keywords ***
Open Web Todolist
    Set Selenium Speed    0.1
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Input data Add Item
    [Arguments]    ${item}
    Wait Until Element Is Visible    ${locator_btn_add}
    Input Text    ${locator_input_item}    ${item}
    Click Element    ${locator_btn_add}

*** Test Cases ***
TC-001 Add Item
    FOR  ${item}  IN  @{list_items}
        Input data Add Item    ${item}
    END
    
TC-002 Verify todo task
    [Documentation]  select task บางรายการ / ลบ task ออกกำลังกาย
    Click Element    ${locator_todoTask}
    Click Element    //label/span[text()='${list_items}[0]']
    Click Element    //label/span[text()='${list_items}[1]']
    Click Element    //label/span[text()='${list_items}[2]']
    Click Element    //li[.//span[text()='${list_items}[3]']]//button[.='Delete']

TC-003 Verify Task in Completed
    [Documentation]  จะต้องไม่มี task ออกกำลังกาย ใน complete
    Click Element    ${locator_completed}
    Element Should Be Visible    //span[text()='${list_items}[0]']/i
    Element Should Be Visible    //span[text()='${list_items}[1]']/i
    Element Should Be Visible    //span[text()='${list_items}[2]']/i
    Element Should Not Be Visible    //span[text()='${list_items}[3]']/i

TC-004 Delete All Task Completed
    [Documentation]    ระวัง: จะ Delete list ไปเรื่อยๆ จนกว่าจะหมด
    [Tags]    delete
    Click Element    ${locator_completed}
    ${list_btn_delete}    Get WebElements       //div[contains(@class, "is-active")]//button[.='Delete']
    FOR  ${btn_delete}  IN  @{list_btn_delete}
        Click Element    //div[contains(@class, "is-active")]//button[.='Delete']
    END
    
TC-005 Delete All Todo Task
    [Documentation]    ระวัง: จะ Delete list ไปเรื่อยๆ จนกว่าจะหมด
    [Tags]    delete
    Click Element    ${locator_todoTask}
    ${list_btn_delete}    Get WebElements       //div[contains(@class, "is-active")]//button[.='Delete']
    FOR  ${btn_delete}  IN  @{list_btn_delete}
        Click Element    //div[contains(@class, "is-active")]//button[.='Delete']
    END