*** Settings ***
Library    Counter.py

*** Test Cases ***
Counter starts
    Counter should display    0


Counter works
    Counter should display    0
    Increment counter
    Increment counter
    Counter should display    2
