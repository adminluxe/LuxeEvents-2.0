import React from 'react'
import * as Sentry from '@sentry/react'

export class ErrorBoundary extends React.Component {
  constructor(props) {
    super(props)
    this.state = { hasError: false }
  }
  static getDerivedStateFromError() {
    return { hasError: true }
  }
  componentDidCatch(error, errorInfo) {
    Sentry.captureException(error, { extra: errorInfo })
  }
  render() {
    if (this.state.hasError) {
      return (
        <div className="p-8 text-center">
          <h1>Oups, une erreur est survenue.</h1>
          <button onClick={() => window.location.reload()} className="mt-4 bg-luxeGold px-4 py-2 rounded">
            Recharger
          </button>
        </div>
      )
    }
    return this.props.children
  }
}
