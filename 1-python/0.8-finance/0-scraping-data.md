# Scraping Financial Data

# 1 - Using Pandas
Pandas datareader allows us to scrape data from authenticated sources such as the Google stock API.

### 1.1 - Importing the datareader
```python
import pandas_datareader.data as web
```
Useful import: datetime
```python
import datetime
```

### 1.2.A - Creating a dataframe with the stock data

```python
start_date = datetime.datetime(year,month,day)
end_date = datetime.datetime(year,month,day)

stock_data = web.DataReader('STOCK_CODE', 'source', start_date, end_date)
```
- This will create a `stock_data` dataframe with the Highest, Lowest, Opening and Closing prices of each day for that stock as well as the Volume traded. Note that these variables can slightly change for each source (ex: google gives the adjusted closing price).
- `'STOCK_CODE'` examples: `'AAPL'`, `'TSLA'`.
- `'source'` examples: `'google'` (might have some issues), `'iex-tops'`

### 1.2.B - Getting Options data
Importing the library (may not work under certain conditions, if using a firewall, for example)
```python
from pandas_datareader.data import Options

stock_options = Options('STOCK_NAME', 'source')

stock_options_df = stock_options.get_options_data(expiry = stock_options.expiry_dates[0])
```

# 2 - Using Quandl
Quandl is a company selling stock data (and other relevant data such as "how many toyotas were sold yesterday"). Most of the "core" stock data is offered for free. Check out [their website](quandl.com).

They have a lot of free data available (much more than Pandas datareader). We can download it from the webpage or use the dedicated python API.

Importing `quandl`:
```python
import quandl
```
## 2.1 Getting stock data
```python
mydata = quandl.get('WIKI/<STOCK_CODE>')
```
- Will create a dataframe with all the time series data (more than pandas datareader) of that particular code.
- `<STOCK_CODE>` examples: `AAPL`, `TSLA`
- Single columns can be retrieved (the full dataframe queried has a lot of them) by adding an index at the end of the request. For example, to get the open price only for the Apple stock, we would use `'WIKI/AAPL.1'` (note that this would require us to know the index of each column).


## 2.2 Getting other time series data
```python
data = quandl.get('Quandl_code')
```
- Imports the data as a pandas dataframe (default)
- The `'Quandl_code'` values can be found in the quandl website. Example: `'EIA/PET_RWT_D'` is the crude oil price.
- Adding an argument `returns = 'numpy'` will return a numpy array of tuples (datetime, value in $)
>Note: we can only do 50 of these requests a day with a free account