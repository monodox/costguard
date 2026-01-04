import streamlit as st
import pandas as pd
from snowflake.snowpark.context import get_active_session

# Get Snowflake session with error handling
try:
    session = get_active_session()
except Exception as e:
    st.error(f"Failed to connect to Snowflake: {str(e)}")
    st.stop()

st.title("🛡️ CostGuard - Snowflake FinOps Dashboard")
st.markdown("Automated warehouse usage and cost analysis")

# Sidebar for controls
st.sidebar.header("Controls")
if st.sidebar.button("Run FinOps Analysis"):
    with st.spinner("Running analysis..."):
        try:
            result = session.call("analysis.run_finops_analysis")
            st.sidebar.success("Analysis completed!")
        except Exception as e:
            st.sidebar.error(f"Analysis failed: {str(e)}")

# Main dashboard
col1, col2 = st.columns(2)

with col1:
    st.subheader("📊 Warehouse Efficiency")
    
    # Get cost insights with error handling
    try:
        insights_df = session.table("analysis.cost_insights").to_pandas()
    except Exception as e:
        st.error(f"Failed to load cost insights: {str(e)}")
        insights_df = pd.DataFrame()
    
    if not insights_df.empty:
        # Efficiency score chart
        st.bar_chart(insights_df.set_index('WAREHOUSE_NAME')['EFFICIENCY_SCORE'])
        
        # Cost spikes alert
        spikes = insights_df[insights_df['COST_SPIKE_DETECTED'] is True]
        if not spikes.empty:
            st.error(f"⚠️ Cost spikes detected in {len(spikes)} warehouses")
            st.dataframe(spikes[['WAREHOUSE_NAME', 'EFFICIENCY_SCORE']])

with col2:
    st.subheader("💰 Cost Analysis")
    
    if not insights_df.empty:
        # Idle time analysis
        high_idle = insights_df[insights_df['IDLE_TIME_PERCENTAGE'] > 50]
        if not high_idle.empty:
            st.warning(f"🔍 {len(high_idle)} warehouses with high idle time")
            st.dataframe(high_idle[['WAREHOUSE_NAME', 'IDLE_TIME_PERCENTAGE']])
        
        # Recommendations
        st.subheader("🎯 AI Recommendations")
        for _, row in insights_df.iterrows():
            if row['AI_RECOMMENDATION']:
                st.info(f"**{row['WAREHOUSE_NAME']}**: {row['AI_RECOMMENDATION']}")

# Usage trends
st.subheader("📈 Usage Trends")
try:
    usage_df = session.table("core.warehouse_usage").to_pandas()
except Exception as e:
    st.error(f"Failed to load usage data: {str(e)}")
    usage_df = pd.DataFrame()

if not usage_df.empty:
    # Convert date column
    usage_df['USAGE_DATE'] = pd.to_datetime(usage_df['USAGE_DATE'])
    
    # Credits over time
    st.line_chart(usage_df.set_index('USAGE_DATE')['TOTAL_CREDITS_USED'])
    
    # Detailed table
    st.dataframe(usage_df)
else:
    st.info("No usage data available. Please load warehouse usage data first.")