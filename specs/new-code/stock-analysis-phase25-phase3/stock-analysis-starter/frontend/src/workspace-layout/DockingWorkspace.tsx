import FlexLayout from 'flexlayout-react';
import 'flexlayout-react/style/light.css';
import MultiTimeframeChartSet from '../chart-workbench/MultiTimeframeChartSet';

const model = FlexLayout.Model.fromJson({
  global: {},
  layout: {
    type: 'row',
    children: [
      {
        type: 'tabset',
        weight: 70,
        children: [{ type: 'tab', name: 'Charts', component: 'charts' }],
      },
      {
        type: 'tabset',
        weight: 30,
        children: [{ type: 'tab', name: 'Symbol Context', component: 'context' }],
      },
    ],
  },
});

export default function DockingWorkspace() {
  const factory = (node: FlexLayout.TabNode) => {
    const component = node.getComponent();
    if (component === 'charts') return <MultiTimeframeChartSet />;
    if (component === 'context') return <div style={{ padding: 12 }}>Symbol context and rule explanation panels go here.</div>;
    return <div>Unknown tab</div>;
  };

  return <FlexLayout.Layout model={model} factory={factory} />;
}
