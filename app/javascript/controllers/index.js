import { application } from "./application";

import HelloController from "./hello_controller";
application.register("hello", HelloController);

import ScrollToBottomOfMessagesController from "./scroll_to_bottom_of_messages_controller";
application.register(
  "scroll-to-bottom-of-messages",
  ScrollToBottomOfMessagesController
);
