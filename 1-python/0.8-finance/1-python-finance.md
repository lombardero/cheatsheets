# Python for Finance

# 0 - Basic metrics

- Daily returns: day-to-day percentage of return (of a portfolio). The average daily returns estimates how well a day behaved, while the standard deviation measure the volatility of these assets.
- Cumulative Return: overall amount variation over a period of time.
- Sharpe Ratio: measure to quantify risk-adjusted returns (looking for returns, but penalizing volatility): S =(R_p - R_f)/sigma_p
    - R_p: daily average returns
    - R_f: risk-free return (return we would receive if we put the money in a risk-free return, can approximate to zero sometimes), original formula was though for yearly returns, not daily
    - sigma_p: daily standard dev
    > Note: annualized Sharpe Ratio can be used (with daily data) by multiplying it by a K factor equal to sqrt(252) - number of working days
