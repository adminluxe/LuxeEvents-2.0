import { InlineConfig } from 'vite';
import { b as ViteSSGOptions } from './shared/vite-ssg.B5F2jCDP.mjs';
import '@unhead/vue';
import 'beasties';
import 'vue';
import 'vue-router';

declare function build(ssgOptions?: Partial<ViteSSGOptions>, viteConfig?: InlineConfig): Promise<void>;

export { build };
