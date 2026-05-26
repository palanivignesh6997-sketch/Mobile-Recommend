import streamlit as st

from mob_rec import (
    df,
    recommend_mobile
)

st.title(
    "Mobile Recommendation System"
)

st.write(
    "Get recommended mobiles "
    "based on source, price and rating."
)

source_mapping = {
    0: 'Amazon',
    1: 'Flipkart',
    2: 'AliExpress',
    3: 'BestBuy',
    4: 'eBay'
}

source_list = list(
    source_mapping.values()
)

selected_source_name = st.selectbox(
    "Select Source",
    source_list
)

reverse_mapping = {
    v: k for k, v in source_mapping.items()
}

selected_source = reverse_mapping[
    selected_source_name
]

rating_options = [1, 2, 3, 4, 5]

min_rating = st.selectbox(
    "Select Minimum Rating",
    rating_options,
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

elif max_price > 100000:

    st.warning(
        "Very high price entered"
    )

if st.button(
    "Get Recommendations"
):

    if max_price < 0:

        st.error(
            "Please enter valid price"
        )

    else:

        result = recommend_mobile(
            selected_source,
            max_price,
            min_rating
        )

        if isinstance(result, str):

            st.error(result)

        else:

            result['source'] = result[
                'source'
            ].replace(source_mapping)

            result['cluster'] = result[
                'cluster'
            ].replace({
                0: 'Low Satisfaction',
                1: 'High Satisfaction',
                2: 'Neutral'
            })

            st.success(
                "Recommended Mobiles"
            )

            st.dataframe(result)
