import React from 'react';
import ReactDOM from 'react-dom/client';
import { QueryClient, QueryClientProvider } from '@tanstack/react-query';
import { BrowserRouter, HashRouter } from 'react-router-dom';
import App from './routes/App';
import './styles.css';
import { DesktopBridge } from './platform/desktop/DesktopBridge';

const queryClient = new QueryClient();
const RouterImpl = DesktopBridge.isDesktop() ? HashRouter : BrowserRouter;

ReactDOM.createRoot(document.getElementById('root')!).render(
  <React.StrictMode>
    <QueryClientProvider client={queryClient}>
      <RouterImpl>
        <App />
      </RouterImpl>
    </QueryClientProvider>
  </React.StrictMode>,
);
