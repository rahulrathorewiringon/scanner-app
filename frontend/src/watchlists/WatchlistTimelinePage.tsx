import { useParams, Link } from 'react-router-dom';
import { useWatchlistAuditTimeline } from '../hooks/api/useAuditTimeline';

export default function WatchlistTimelinePage() {
  const { watchlistId } = useParams();
  const query = useWatchlistAuditTimeline(watchlistId ? Number(watchlistId) : undefined);

  return (
    <div style={{ padding: 20, display: 'grid', gap: 16 }}>
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <div>
          <h1 style={{ margin: 0 }}>Watchlist History</h1>
          <div style={{ opacity: 0.75 }}>Audit timeline for watchlist {watchlistId}</div>
        </div>
        <Link to={`/watchlists/${watchlistId}`} style={{ color: '#60a5fa' }}>Back to Watchlist</Link>
      </div>
      <div style={{ border: '1px solid #243043', borderRadius: 8, background: '#111827', padding: 16 }}>
        {query.isLoading ? <div>Loading…</div> : query.error ? <div>Failed to load timeline.</div> : (
          <div style={{ display: 'grid', gap: 10 }}>
            {query.data?.events?.map((event) => (
              <div key={event.auditEventId} style={{ border: '1px solid #243043', borderRadius: 8, padding: 12 }}>
                <div><strong>{event.eventType}</strong> · {event.entityType}</div>
                <div style={{ opacity: 0.75 }}>{event.userId} · {event.eventTs}</div>
                <pre style={{ whiteSpace: 'pre-wrap', fontSize: 12, marginTop: 8 }}>{JSON.stringify({ before: event.beforeJson, after: event.afterJson }, null, 2)}</pre>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}
