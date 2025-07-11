import { Component } from 'vue';
import { V as ViteSSGContext, a as ViteSSGClientOptions } from '../shared/vite-ssg.B5F2jCDP.mjs';
export { R as RouterOptions, b as ViteSSGOptions } from '../shared/vite-ssg.B5F2jCDP.mjs';
import '@unhead/vue';
import 'beasties';
import 'vue-router';

declare function ViteSSG(App: Component, fn?: (context: ViteSSGContext<false>) => Promise<void> | void, options?: ViteSSGClientOptions): () => Promise<ViteSSGContext<false>>;

export { ViteSSG, ViteSSGClientOptions, ViteSSGContext };
