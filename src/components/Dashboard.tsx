import React from "react";
import { Boarder } from "../types";
import { getMonthKey } from "../storage";

export default function Dashboard(props: {
  boarders: Boarder[]; month: string; onChangeMonth: (m: string) => void; onAdd: () => void; onSelect: (b: Boarder) => void;
}) {
  const { boarders, month } = props;
  const totals = boarders.reduce((acc, b) => {
    acc.totalRent += b.rent;
    const fees = b.fees.reduce((s, f) => s + f.amount, 0);
    acc.fees += fees;
    return acc;
  }, { totalRent: 0, fees: 0 });
  // unpaid count = boarders without payment record for selected month or marked unpaid
  const unpaidCount = boarders.filter(b => !(b.payments.find(p => p.month === month)?.paid)).length;
  return (
    <div style={{ marginBottom: 16 }}>
      <div style={{ display: "flex", gap: 8, marginBottom: 8 }}>
        <div style={{ padding: 12, border: "1px solid #ddd" }}>
          <div>Total Rent (per month)</div><strong>${totals.totalRent.toFixed(2)}</strong>
        </div>
        <div style={{ padding: 12, border: "1px solid #ddd" }}>
          <div>Additional Fees (all-time)</div><strong>${totals.fees.toFixed(2)}</strong>
        </div>
        <div style={{ padding: 12, border: "1px solid #ddd" }}>
          <div>Unpaid Boarders ({month})</div><strong>{unpaidCount}</strong>
        </div>
        <div style={{ marginLeft: "auto" }}>
          <button onClick={() => props.onAdd()}>+ Add</button>
        </div>
      </div>

      <div style={{ marginBottom: 8 }}>
        <label>Month: </label>
        <input type="month" value={month} onChange={e => props.onChangeMonth(e.target.value)} />
        <button onClick={() => props.onChangeMonth(getMonthKey())}>Current</button>
      </div>

      <ul>
        {boarders.map(b => {
          const paid = b.payments.find(p => p.month === month)?.paid ?? false;
          const balance = b.fees.reduce((s, f) => s + f.amount, 0) + (paid ? 0 : b.rent);
          return (
            <li key={b.id} style={{ padding: 8, borderBottom: "1px solid #eee", display: "flex", justifyContent: "space-between" }}>
              <div onClick={() => props.onSelect(b)} style={{ cursor: "pointer" }}>
                <strong>{b.name}</strong> — Room {b.room} — ${b.rent.toFixed(2)}
              </div>
              <div>
                <span style={{ marginRight: 12 }}>{paid ? "Paid" : "Unpaid"}</span>
                <span>${balance.toFixed(2)}</span>
              </div>
            </li>
          );
        })}
      </ul>
    </div>
  );
}
