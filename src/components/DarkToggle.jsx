import { useEffect, useState } from 'react'
import { Sun, Moon } from 'lucide-react'

export default function DarkToggle() {
  const [mode, setMode] = useState('light')
  useEffect(()=>{
    const m = localStorage.theme || 'light'
    setMode(m)
    document.documentElement.classList.toggle('dark', m==='dark')
  },[])
  const toggle = ()=>{
    const m = mode==='light' ? 'dark' : 'light'
    localStorage.theme = m
    document.documentElement.classList.toggle('dark', m==='dark')
    setMode(m)
  }
  return (
    <button onClick={toggle} className="p-2">
      {mode==='light' ? <Moon/> : <Sun/>}
    </button>
  )
}
