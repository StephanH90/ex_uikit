import UIkit from "./uikit/uikit.min.js";
import UIkitIcon from "./uikit/uikit-icons.min.js";

UIkit.use(UIkitIcon);

export const UIkitHooks = {
  UkIcon: {
    mounted() {
      UIkit.icon(this.el.id, {});
    },
  },
  UkModal: {
    mounted() {
      // UIkit moves the dom element to somewhere else in the dom
      // Therefore we wrap it with a div that will stay in the dom that
      // LiveView can use to dispatch events, etc.
      const modalEl = this.el.children[0];
      this.modal = UIkit.modal(modalEl, {});
      if (this.el.dataset.shown === "true") {
        this.modal.show();
      }
      modalEl.addEventListener("hide", () => {
        if (this.el.dataset.shown === "true" && this.el.dataset.onHide) {
          this.js().exec(this.el.dataset.onHide);
        }
      });
    },
    updated() {
      if (this.el.dataset.shown === "true") {
        this.modal.show();
      }
      if (this.el.dataset.shown === "false") {
        this.modal.hide();
      }
    },
    destroyed() {
      this.modal?.hide();
    },
  },
};
