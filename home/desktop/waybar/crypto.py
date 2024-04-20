#!/usr/bin/env python
import requests
import json


def get_top_cryptos():
    """
    Retrieves information about the top cryptocurrencies from the CoinGecko API.

    Returns:
        dict: A dictionary containing information about the top cryptocurrencies.
            The dictionary has the following keys:
            - "text": A string representing a Unicode character.
            - "alt": A string representing a Unicode character.
            - "tooltip": A string representing the tooltip text for the cryptocurrencies.
            - "class": A string representing the CSS class for the cryptocurrencies.
    """
    url = "https://api.coingecko.com/api/v3/coins/markets"
    params = {
        "vs_currency": "usd",
        "order": "market_cap_desc",
        "per_page": 10,
        "price_change_percentage": "24h",
        "page": 1,
    }

    response = requests.get(url, params=params)

    if response.status_code == 200:
        top_cryptos = response.json()
        tooltip = '<span size="xx-large">Crypto</span>\n'
        for crypto in top_cryptos:
            name = crypto["name"]
            symbol = crypto["symbol"]
            price = crypto["current_price"]
            change = crypto["price_change_percentage_24h"]
            tooltip += str(f"  <b>{name}</b>: ${price}  |  {change:.2f}%\n")

        out_data = {
            "text": f"󰠓",
            "alt": f"",
            "tooltip": tooltip,
            "class": "weather",
        }
        return out_data
    else:
        exit(1)


print(json.dumps(get_top_cryptos()))
