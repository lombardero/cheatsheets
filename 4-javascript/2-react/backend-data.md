# Getting data from the backend

- [Getting data from the backend](#getting-data-from-the-backend)
- [Mocking data](#mocking-data)
- [Axios](#axios)
  - [Getting data from the backend](#getting-data-from-the-backend-1)
  - [Displaying data from the backend](#displaying-data-from-the-backend)
  - [Raising errors](#raising-errors)
- [React Query](#react-query)
  - [Mutations](#mutations)
    - [`UseMutation`](#usemutation)
- [Redux Query](#redux-query)
  - [Redux middleware](#redux-middleware)
  - [How it works](#how-it-works)

# Mocking data

Use th[`json-server` library](https://github.com/typicode/json-server) to create a mock REST endpoint to test getting data

# Axios

## Getting data from the backend

Use the [axios libary](https://www.npmjs.com/package/axios) to interact with the backend (making rest calls from the UI)

Example of

```tsx
// In a separate 'client.ts' configuration file
export const client = axios.create({ baseURL: API_BASE_URL });

// In the logic code:
import { Event } from "../types";
import { client } from "./client";

export const getEvents = async (
  isFreeEntry?: boolean,
  isWheelchairAccessible?: boolean
): Promise<Event[]> => {
  const response = await client.get<Event[]>("events", {
    params: {
      isFreeEntry: isFreeEntry || undefined,
      facilities_like: isWheelchairAccessible
        ? "wheelchair-accessible"
        : undefined,
    },
  });
  return response.data;
};
```

- This code awaits responses from the backend

## Displaying data from the backend

We need to store the backend response in some state, so that we can display it:

```tsx
// State
const [events, setEvents] = useState<Event[] | undefined>(undefined);

//
useEffect(() => {
  async function getEventsAndSetStates() {
    setEvents(undefined);
    setIsError(false);
    setIsLoading(true);
    try {
      const response = await getEvents(
        isFreeEntryChecked,
        isWheelchairAccessibleChecked
      );
      setEvents(response);
    } catch (error) {
      setIsError(true);
    } finally {
      setIsLoading(false);
    }
  }
  getEventsAndSetStates();
}, [isFreeEntryChecked, isWheelchairAccessibleChecked]);
```

## Raising errors

Raising errors on the frontend also requires state, so that if the call fails, the state can be set to "failing". It can then be displayed.

# React Query

React Query is a library to easily interact with the backend: fetch data, cache it, synchronize state and update the backend. React Query adds caching for free :sparkles:

Check the [documentation](https://react-query-v3.tanstack.com/overview)

To make it work, we need to wrap our `App` component in a `QueryClientProvider` one:

```tsx
return (
  <ThemeProvider theme={theme}>
    <CssBaseline />
    <QueryClientProvider client={queryClient}>
      {/* Our App goes here */}
    </QueryClientProvider>
  </ThemeProvider>
);
```

## Mutations

> :information_source: Mutations [documentation](https://react-query-v3.tanstack.com/guides/mutations#_top).

### `UseMutation`

> :information_source: `useMutation` [documentation](https://react-query-v3.tanstack.com/reference/useMutation#_top)

React Query enables us to define mutations, which are sort of "event listeners" to something in the UI, which then can trigger side-effects.

Let's look at an example of a mutation which listens to users tapping into a favourite button. The mutation tries to update the backend (changing the value of `isFavorite`), and handles an update error:

```tsx
// Logic code:
const favoriteEventMutation = useMutation({
  mutationFn: ({ id, isFavorite }: { id: string; isFavorite: boolean }) =>
    // Send an update to the backend
    setEventAsFavoriteRemotely(id, isFavorite),
  onMutate: async ({ id, isFavorite }) => {
    // Mutate the local object so it is displayed in the UI
    // This line is a safety guard to cancel any other queries triggered by unwanted effects (e.g. we click somehwere outside the window and that retriggers fetching)
    await queryClient.cancelQueries(queryKey);

    // Get currently cached state
    const previousEvents = queryClient.getQueryData<Event[]>(queryKey);

    // Update currently cached state optimistically (assuming backend call succeeds)
    if (previousEvents) {
      const nextEvents = previousEvents.map((previousEvent) =>
        previousEvent.id === id
          ? { ...previousEvent, isFavorite }
          : previousEvent
      );
      queryClient.setQueryData<Event[]>(queryKey, nextEvents);
    }

    return { previousEvents };
  },
  onError: (_err, _variables, context) => {
    if (context?.previousEvents) {
      queryClient.setQueryData<Event[]>(queryKey, context.previousEvents);
    }
  },
});

// Caller code in JSX
<EventItem
  key={event.id}
  event={event}
  onFavoriteButtonClick={() =>
    favoriteEventMutation.mutate({
      id: event.id,
      isFavorite: !event.isFavorite,
    })
  }
/>;
```

- `mutationFn`: async function triggered when `.mutate` is called (usually: backend call)
- `onMutate`: immediate action to be done in the fronted
- `onError`: what to do if `mutationFn` fails
  - `context`: generic variable available in `onError` containing whatever `onMutate` returned

with the backend, for example,

```tsx
const queryClient = useQueryClient();

const queryKey = ["events", isFreeEntryChecked, isWheelchairAccessibleChecked];

const eventsQuery = useQuery({
  queryKey,
  queryFn: () => getEvents(isFreeEntryChecked, isWheelchairAccessibleChecked),
});
```

# Redux Query

> :information_source: Redux core implementation, see [documentation](https://redux.js.org/).

> :information_source: Redux Query Toolkit [documentation](https://redux-toolkit.js.org/rtk-query/overview). Redux Toolkit is an opinionated wrapper of Redux core with a simplified API

Redux is a library enabling to manage state (as we saw in the [React query part](backend-data.md#react-query), it might be quite diffucult). Useful when data is needed in several parts of application.

> :bulb: Redux is useful when the application has a lot of state on the client side.

Redux introduces the idea of a "reducer", which is a pure function allowing to manage state through actions:

- Actions can be of type (e.g. `"SET_VALUE"` to some value, `"RESET_VALUE"`). Note that actions are triggered via the "dispatcher"
- The reducer takes in that instruction and manages the state

Redux also allow us to introduce Middleware to add side-effects to actions. For example, triggering backend calls to fetch/update some data. This middleware will also change the state if needed (for ex: once certain value is available)

## Redux middleware

> :information_source: Redux thunks [documentation](https://redux.js.org/usage/writing-logic-thunks).

## How it works

Redux Query asks us to define state `type`, an initial state, and event slices. For example:

```tsx
type EventState = {
    readonly events: Event[] | undefined;
    readonly isError: boolean;
    readonly isLoading: boolean;
};

const initialState: EventsState = {
    events: undefined,
    isError: false,
    isLoading: false,
}

//
export const getEvents = createAsyncThunk(
    "getEvents",
    async ( payload: {
        isFreeEntry?: boolean;
        isWheelchairAccessible?: boolean;
        }) =>
        await getEventsFromApi(payload.isFreeEntry, payload.isWheelchairAccessible)
)

// Slices allow us to define the interaction with state, based on what is the status of the action
const eventsSlice = createSlice({
    name: "events",
    initialState,
    reducers: {
        setEventasFavoriteLocally: (state, action) => {
            ...
        }
    },
    extraReducers: ( builder ) => {
        builder.addCase(getEvents.pending, (state) => {
            state.events = undefined;
            state.isError = false;
            state.isLoading = true;
            });
        builder.addCase(getEvents.fulfilled, (state, action) => {
            state.events = action.payload;
            state.isLoading = false;
        });
        builder.addCase(getEvents.rejected, (state) => {
            state.isError = false;
            state.isLoading = true;
        });
    },
});
```

> Note that Redux uses a JS library which does immutable changes using mutable syntax
