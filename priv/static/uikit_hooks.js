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
  UkDropdown: {
    mounted() {
      const options = {
        mode: this.el.dataset.mode,
        pos: this.el.dataset.pos,
        animation: this.el.dataset.animation,
        duration: parseInt(this.el.dataset.duration),
        offset: parseInt(this.el.dataset.offset),
        'delay-show': parseInt(this.el.dataset.delayShow),
        'delay-hide': parseInt(this.el.dataset.delayHide),
      };

      if (this.el.dataset.boundary) {
        options.boundary = this.el.dataset.boundary;
      }

      if (this.el.dataset.target) {
        options.target = this.el.dataset.target;
      }

      if (this.el.dataset.stretch === 'true' || this.el.dataset.stretch === 'false') {
        options.stretch = this.el.dataset.stretch === 'true';
      } else if (this.el.dataset.stretch) {
        options.stretch = this.el.dataset.stretch;
      }

      if (this.el.dataset.large === 'true') {
        this.el.classList.add('uk-dropdown-large');
      }

      if (this.el.dataset.flip === 'true' || this.el.dataset.flip === 'false') {
        options.flip = this.el.dataset.flip === 'true';
      }

      if (this.el.dataset.shift === 'true' || this.el.dataset.shift === 'false') {
        options.shift = this.el.dataset.shift === 'true';
      }

      if (this.el.dataset.autoUpdate === 'true' || this.el.dataset.autoUpdate === 'false') {
        options['auto-update'] = this.el.dataset.autoUpdate === 'true';
      }

      this.dropdown = UIkit.dropdown(this.el, options);
    },
    destroyed() {
      this.dropdown?.hide();
    },
  },
};
