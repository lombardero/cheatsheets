# Loading data sets in `pytorch`


# Basic loading
```py
data = torch.load('file')
```
- Loads whatever data is in the specified file


# Loading iterables

The basic way of loading datasets in Pytorch is using the Dataloader.
```py
dataloader = toch.utils.data.Dataloader(dataset, batch_size = bs,
                                    shuffle = True,
                                    num_workers = n)
```
- creates a generator function that slices the dataset in batches and yields one
  batch at a time. Every `next()` call goes through a new iteration of the set.
- `batch_size` fixes the size of the batches used for updating the weights; each
  batch contains `bs` tuples with the image and the label
- `shuffle = True` means that each time the iterations are completed (every epoch),
  the data is shuffled randomly
- `num_workers` lets you divide the processing into n multiprocessing workers to
  improve performance

# Iterating through the loaded data
```py
for batch , (train,label) in enumerate(dataloader)
```
- iterates through batches and training data (equivalent to 2 for loops).
  [Check out](https://pytorch.org/docs/stable/data.html)

```py
iter(dataloader)
```
- allows the dataloader pytorch object to be iterable; the `next()` function can be
  called

```py
iter(dataloader).next()
```
- returns one iteration, which consists of a list of two tensors:
  - the first is a torch 4-Dimensional tensor, `([batch_size, C, H, W])`
    (list of inputs in the batch)
  - the second is a torch 1-Dimensional tensor, with the labels of each of the elements
    in the batch (size is batch_size)
