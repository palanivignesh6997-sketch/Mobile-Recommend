import streamlit as st

from mob_rec import (
    recommend_mobile
)

st.set_page_config(
    page_title="Mobile Recommendation System"
)

st.title("Mobile Recommendation System")

source_mapping = {
    0: 'AliExpress',
    1: 'Amazon',
    2: 'BestBuy',
    3: 'Flipkart',
    4: 'eBay'
}

brand_mapping = {
    0: 'Apple',
    1: 'Google',
    2: 'Motorola',
    3: 'OnePlus',
    4: 'Realme',
    5: 'Samsung',
    6: 'Xiaomi'
}

cluster_mapping = {
    0: 'Average Satisfaction',
    1: 'High Satisfaction',
    2: 'Low Satisfaction'
}

source_list = list(
    source_mapping.values()
)

selected_source_name = st.selectbox(
    "Select Source",
    source_list
)

reverse_source_mapping = {
    v: k for k, v in source_mapping.items()
}

selected_source = reverse_source_mapping[
    selected_source_name
]

brand_list = list(
    brand_mapping.values()
)

selected_brand_name = st.selectbox(
    "Select Brand",
    brand_list
)

reverse_brand_mapping = {
    v: k for k, v in brand_mapping.items()
}

selected_brand = reverse_brand_mapping[
    selected_brand_name
]

min_rating = st.selectbox(
    "Select Minimum Rating",
    [1, 2, 3, 4, 5],
    index=2
)

max_price = st.number_input(
    "Enter Maximum Price",
    value=1000.0,
    step=100.0
)

if max_price < 0:

    st.warning(
        "Price cannot be negative"
    )

if st.button(
    "Get Recommendations"
):

    result = recommend_mobile(
        selected_source,
        selected_brand,
        max_price,
        min_rating
    )

    if isinstance(result, str):

        st.error(result)

    else:

        result['source'] = result[
            'source'
        ].replace(source_mapping)

        result['brand'] = result[
            'brand'
        ].replace(brand_mapping)

        result['cluster'] = result[
            'cluster'
        ].replace(cluster_mapping)

        st.success(
            "Recommended Mobiles"
        )

        st.dataframe(result)
