"""
Minimal test app to debug connection reset issue
"""
import streamlit as st

st.set_page_config(
    page_title="Test App",
    layout="wide"
)

st.title("Test App")
st.write("If you see this, the app is working!")

