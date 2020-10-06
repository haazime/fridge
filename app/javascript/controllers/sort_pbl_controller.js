import { Controller } from 'stimulus';
import Sortable, { AutoScroll } from 'sortablejs/modular/sortable.core.esm.js'

const uiOptions = {
  handle: '.js-sortable-handle',
  scroll: true,
  animation: 150,
  easing: 'cubic-bezier(1, 0, 0, 1)',
  ghostClass: '.sortable-ghost'
}

export default class extends Controller {
  initialize() {
    Sortable.mount(new AutoScroll())
  }

  connect() {
    const url = this.data.get('url')

    Sortable.create(this.element, {
      ...uiOptions,
      onEnd: function(e) {
        const payload = {
          issue_id: e.item.dataset.id,
          to_index: e.newIndex,
        }
        $.ajax({ type: 'PATCH', url: url, dataType: 'json', data: payload })
      }
    })
  }
}
