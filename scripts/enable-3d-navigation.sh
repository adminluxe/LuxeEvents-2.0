#!/bin/bash

echo "🚀 Activation des transitions 3D entre pages..."

APP_FILE="src/App.jsx"

# 1. Ajout des imports nécessaires
sed -i "/import { BrowserRouter as Router, Route, Routes } from 'react-router-dom';/a import { useLocation } from 'react-router-dom';\nimport { AnimatePresence, motion } from 'framer-motion';" "$APP_FILE"

# 2. Remplacement du bloc <Routes> classique
# Sauvegarde d'abord
cp "$APP_FILE" "$APP_FILE.bak"

# 3. Remplace le contenu des <Routes> par la version animée
sed -i '/<Routes>/,/<\/Routes>/c\
      const location = useLocation();\
      \
      <AnimatePresence mode="wait">\
        <Routes location={location} key={location.pathname}>\
          <Route path="/" element={\
            <motion.div\
              initial={{ opacity: 0, rotateY: -90 }}\
              animate={{ opacity: 1, rotateY: 0 }}\
              exit={{ opacity: 0, rotateY: 90 }}\
              transition={{ duration: 0.6, ease: \"easeInOut\" }}\
              className=\"min-h-screen\"\
            >\
              <HomePage />\
            </motion.div>\
          } />\
          <Route path="/media" element={\
            <motion.div\
              initial={{ opacity: 0, rotateY: -90 }}\
              animate={{ opacity: 1, rotateY: 0 }}\
              exit={{ opacity: 0, rotateY: 90 }}\
              transition={{ duration: 0.6, ease: \"easeInOut\" }}\
              className=\"min-h-screen\"\
            >\
              <MediaPage />\
            </motion.div>\
          } />\
          <Route path="/services" element={\
            <motion.div\
              initial={{ opacity: 0, rotateY: -90 }}\
              animate={{ opacity: 1, rotateY: 0 }}\
              exit={{ opacity: 0, rotateY: 90 }}\
              transition={{ duration: 0.6, ease: \"easeInOut\" }}\
              className=\"min-h-screen\"\
            >\
              <ServicesPage />\
            </motion.div>\
          } />\
          <Route path="/demande-de-devis" element={\
            <motion.div\
              initial={{ opacity: 0, rotateY: -90 }}\
              animate={{ opacity: 1, rotateY: 0 }}\
              exit={{ opacity: 0, rotateY: 90 }}\
              transition={{ duration: 0.6, ease: \"easeInOut\" }}\
              className=\"min-h-screen\"\
            >\
              <RequestQuotePage />\
            </motion.div>\
          } />\
        </Routes>\
      </AnimatePresence>' "$APP_FILE"

echo "✅ Transitions 3D activées dans src/App.jsx avec succès !"
