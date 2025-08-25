(()=>{try{
  const state = {
    lang: (localStorage.getItem('lx_lang')||'fr'),
    t: {
      fr: {
        services:"Services",
        gallery:"Galerie",
        book:"Demander un devis",
        footer_about:"LuxeEvents orchestre des événements premium — luxe, excellence, innovation.",
        privacy:"Politique de confidentialité",
        legal:"Mentions légales",
        cookies:"Cookies",
        follow:"Suivez-nous",
        lang_label:"Langue",
      },
      en: {
        services:"Services",
        gallery:"Gallery",
        book:"Request a quote",
        footer_about:"LuxeEvents designs premium events — luxury, excellence, innovation.",
        privacy:"Privacy Policy",
        legal:"Legal",
        cookies:"Cookies",
        follow:"Follow us",
        lang_label:"Language",
      }
    }
  };

  const $ = (sel, ctx=document)=>ctx.querySelector(sel);
  const el = (tag, attrs={}, children=[])=>{
    const node=document.createElement(tag);
    Object.entries(attrs).forEach(([k,v])=>{
      if(k==='class') node.className=v;
      else if(k==='html') node.innerHTML=v;
      else node.setAttribute(k,v);
    });
    (Array.isArray(children)?children:[children]).filter(Boolean).forEach(c=>{
      node.appendChild(typeof c==='string'?document.createTextNode(c):c);
    });
    return node;
  };

  // Styles minimalistes (mobile-first, sobers, luxe vibes)
  const css = `
  :root{--gold:#C5A36A;--ink:#0c0b0b;--fog:#f7f5f2}
  .lx-wrap{max-width:1080px;margin:0 auto;padding:clamp(12px,3vw,28px)}
  .lx-grid{display:grid;gap:clamp(12px,2.5vw,24px)}
  @media(min-width:900px){.lx-grid-2{grid-template-columns:1fr 1fr}}
  h2.lx-title{font-family:Playfair Display,serif;font-weight:600;letter-spacing:.3px;margin:0 0 .6em}
  .lx-muted{color:#555}
  .lx-card{background:white;border:1px solid #eee;border-radius:16px;box-shadow:0 6px 22px rgba(12,11,11,.06);overflow:hidden}
  .lx-pad{padding:clamp(12px,2.5vw,20px)}
  .lx-btn{display:inline-block;border:1px solid var(--gold);color:var(--ink);padding:.75rem 1rem;border-radius:999px;text-decoration:none}
  .lx-btn:hover{background:var(--gold);color:#fff;transition:all .2s}
  .lx-sec{margin:clamp(18px,5vw,48px) 0}
  .lx-sec hr{border:0;height:1px;background:#eee;margin:24px 0}
  .lx-gallery{display:grid;grid-template-columns:repeat(2,1fr);gap:10px}
  @media(min-width:680px){.lx-gallery{grid-template-columns:repeat(4,1fr)}}
  .lx-gallery img{width:100%;height:auto;border-radius:12px;display:block}
  .lx-services li{display:grid;grid-template-columns:auto 1fr;gap:12px;align-items:start;padding:12px 0;border-bottom:1px solid #efefef}
  .lx-services strong{color:var(--ink)}
  .lx-footer{background:var(--ink);color:#ddd;padding:32px 0;margin-top:40px}
  .lx-footer a{color:#ddd;text-decoration:none}
  .lx-footer a:hover{color:#fff}
  .lx-row{display:flex;flex-wrap:wrap;gap:18px;align-items:center;justify-content:space-between}
  .lx-lang{display:flex;gap:8px;align-items:center}
  .lx-badge{background:var(--gold);color:#fff;border-radius:999px;padding:.15rem .55rem;font-size:.85rem}
  `;
  const style=el('style',{id:'lx-enhance-css',html:css}); document.head.appendChild(style);

  // Header tools (language switcher)
  const mountTarget = document.body; // indépendant du bundle
  const headerTools = el('div',{class:'lx-wrap lx-row',style:'margin-top:10px'},
    [
      el('div',{class:'lx-badge'},'Luxe • Excellence • Innovation'),
      el('div',{class:'lx-lang'},
        [ el('span',{},state.t[state.lang].lang_label+' :'),
          ...['fr','en'].map(code=>{
            const btn=el('button',{class:'lx-btn',style:`padding:.35rem .7rem;border-radius:10px;border-color:${state.lang===code?'#C5A36A':'#ddd'};`}, code.toUpperCase());
            btn.onclick=()=>{ localStorage.setItem('lx_lang',code); location.reload(); };
            return btn;
          })
        ]
      )
    ]
  );

  // SERVICES
  const S = [
    {title:{fr:'Mariages haut de gamme',en:'High-end weddings'}, desc:{fr:'Direction artistique complète, du concept aux détails.',en:'Full art direction, from concept to details.'}},
    {title:{fr:'Événements corporate',en:'Corporate events'}, desc:{fr:'Lancements, séminaires, soirées de gala clés en main.',en:'Launches, offsites, black-tie galas.'}},
    {title:{fr:'Expériences privées',en:'Private experiences'}, desc:{fr:'Anniversaires, fiançailles, moments d’exception.',en:'Milestones, engagements, intimate excellence.'}},
    {title:{fr:'Scénographie & déco',en:'Scenography & decor'}, desc:{fr:'Ambiances signature, matériaux nobles & éclairages.',en:'Signature atmospheres, fine materials & lights.'}},
  ];
  const sv = el('section',{class:'lx-sec'},[
    el('div',{class:'lx-wrap'},
      [ el('h2',{class:'lx-title'}, state.t[state.lang].services),
        el('ul',{class:'lx-services'},
          S.map(it=>el('li',{},[
            el('span',{class:'lx-badge'},'•'),
            el('div',{},[ el('strong',{}, it.title[state.lang]), el('div',{class:'lx-muted'}, it.desc[state.lang]) ])
          ]))
        ),
        el('p',{}, el('a',{href:'#contact',class:'lx-btn'}, state.t[state.lang].book))
      ])
    )
  ]);

  // GALLERY (utilise tes PNG restaurés; fallback si absent)
  const imgs=(i)=>[`/images/gallery/thumb${i}.png`,`/images/gallery/thumb${i}.webp`];
  const gallery = el('section',{class:'lx-sec'},[
    el('div',{class:'lx-wrap'},[
      el('h2',{class:'lx-title'}, state.t[state.lang].gallery),
      el('div',{class:'lx-gallery',id:'lx-gallery'})
    ])
  ]);
  const gwrap = $('div#lx-gallery', gallery);
  for(let i=1;i<=8;i++){
    const it=el('img',{loading:'lazy',alt:`LuxeEvents ${i}`,src:imgs(i)[0]});
    it.addEventListener('error',()=>{ it.src=imgs(i)[1]; },{once:true});
    gwrap.appendChild(el('div',{class:'lx-card'}, el('div',{class:'lx-pad'}, it)));
  }

  // FOOTER
  const footer = el('footer',{class:'lx-footer'},[
    el('div',{class:'lx-wrap lx-grid lx-grid-2'},[
      el('div',{},[
        el('div',{style:'font-weight:600;margin-bottom:.5rem'},'LuxeEvents'),
        el('div',{class:'lx-muted'}, state.t[state.lang].footer_about)
      ]),
      el('div',{},[
        el('div',{style:'margin-bottom:.5rem;font-weight:600'}, state.t[state.lang].follow),
        el('div',{class:'lx-row'},
          [
            el('a',{href:'https://www.instagram.com/',target:'_blank',rel:'noopener'},'Instagram'),
            el('a',{href:'https://www.facebook.com/',target:'_blank',rel:'noopener'},'Facebook'),
            el('a',{href:'mailto:grouppurpleorchid@gmail.com'},'Contact')
          ]
        ),
        el('hr'),
        el('div',{class:'lx-row'},
          [
            el('a',{href:'#privacy'}, state.t[state.lang].privacy),
            el('a',{href:'#legal'},   state.t[state.lang].legal),
            el('a',{href:'#cookies'}, state.t[state.lang].cookies),
          ]
        )
      ])
    ])
  ]);

  // Montage — sous le root existant, on ajoute nos sections (non intrusif)
  mountTarget.appendChild(headerTools);
  mountTarget.appendChild(sv);
  mountTarget.appendChild(gallery);
  mountTarget.appendChild(footer);

}catch(e){console.error('[enhance]',e)}})();
