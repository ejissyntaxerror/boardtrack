import React from "react";
import { Boarder } from "../types";
import { forMonth } from "../storage";

export default function MonthlySummary(props: { boarders: Boarder[]; month: string; onExport: (data: any) => void; }) {
  const rows = forMonth(props.boarders, props.month);
  const totalCollected = rows.reduce((s, r) => s + (r.paid ? r.boarder.rent : 0) + r.feesThisMonth.reduce((x, f) => x + f.amount, 0), 0);
  const unpaidCount = rows.filter(r => !r.paid).length;
  const unpaidTotal = rows.reduce((s, r) => s + (r.paid ? 0 : r.boarder.rent) + r.feesThisMonth.reduce((x, f) => x + f.amount, 0), 0);
  return (
    <div style={{ marginTop: 12, borderTop: "1px solid #ddd", paddingTop: 12 }}>
      <h3>Monthly Summary — {props.month}</h3>
      <div>Total Collected: ${totalCollected.toFixed(2)}</div>
      <div>Unpaid Boarders: {unpaidCount}</div>
      <div>Unpaid Balances: ${unpaidTotal.toFixed(2)}</div>
      <div style={{ marginTop: 8 }}>
        <button onClick={() => props.onExport({ month: props.month, rows })}>Export JSON</button>
      </div>
    </div>
  );
}
