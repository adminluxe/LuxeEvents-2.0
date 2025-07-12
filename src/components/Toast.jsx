import tippy from 'tippy.jsx';
import 'tippy.js/dist/tippy.css';
export function showToast(message, type='info') {
  tippy(document.body, { content: message, trigger: 'manual', hideOnClick: true, theme: type }).show();
}
