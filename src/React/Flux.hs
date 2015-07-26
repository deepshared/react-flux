module React.Flux (
  -- * Stores and dispatch
    ReactStore
  , StoreData(..)
  , SomeStoreAction(..)
  , mkStore
  , dispatch
  , dispatchSomeAction

  -- * Classes
  , ReactClass
  , ViewEventHandler
  , mkControllerView
  , mkView
  , StatefulViewEventHandler
  , mkStatefulView
  , ClassEventHandler
  , mkClass

  -- * Elements
  , ReactElement
  , ReactElementM(..)
  , rclass
  , rclassWithKey
  --, foreignClass
  , module React.Flux.DOM
  , module React.Flux.PropertiesAndEvents

  -- * Main
  , reactRender
) where

import React.Flux.Class
import React.Flux.DOM
import React.Flux.Element
import React.Flux.PropertiesAndEvents
import React.Flux.Store

----------------------------------------------------------------------------------------------------
-- reactRender has two versions
----------------------------------------------------------------------------------------------------

-- | Render your React application into the DOM.

#ifdef __GHCJS__

reactRender :: String -- ^ The ID of the HTML element to render the application into.
                      -- (This string is passed to @document.getElementById@)
            -> ReactClass props -- ^ A single instance of this class is created
            -> props -- ^ the properties to pass to the class
            -> IO ()
reactRender htmlId rc props = do
    (elem, _) <- mkReactElementM $ ClassInstance rc props Nothing EmptyElement
    js_ReactRender elem (toJSString htmlId)

foreign import javascript unsafe
    "React.render($1, document.getElementById($2))"
    js_ReactRender :: ReactElementRef -> JSString -> IO ()

#else

reactRender :: String -- ^ The ID of the HTML element to render the application into.
                      -- (This string is passed to @document.getElementById@)
            -> ReactClass props -- ^ A single instance of this class is created
            -> props -- ^ the properties to pass to the class
            -> IO ()
reactRender _ _ _ = return ()

#endif
