import React, { useState } from "react";
import { Boarder } from "../types";
import { uid, getMonthKey } from "../storage";

export default function BoarderProfile(props: { boarder: Boarder; onSave: (b: Boarder) => void; onClose: () => void; }) {
  const [b, setB] = useState<Boarder>(props.boarder);
  const month = getMonthKey();
  function togglePaid() {
    const payments = [...b.payments];
    const idx = payments.findIndex(p => p.month === month);
    if (idx >= 0) payments[idx].paid = !payments[idx].paid;
    else payments.push({ month, paid: true, updatedAt: new Date().toISOString() });
    setB({ ...b, payments });
  }
  function addFee(name: string, amount: number) {
    const fees = [...b.fees, { id: uid("f_"), name, amount, createdAt: new Date().toISOString() }];
    setB({ ...b, fees });
  }
  function deleteFee(id: string) {
    setB({ ...b, fees: b.fees.filter(f => f.id !== id) });
  }
  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.25)", display: "flex", alignItems: "center", justifyContent: "center" }}>
      <div style={{ background: "white", padding: 16, width: 420 }}>
        <h3>{b.name} — Room {b.room}</h3>
        <div>Rent: ${b.rent.toFixed(2)}</div>
        <div style={{ marginTop: 8 }}>
          <label>Current month ({month}) status: </label>
          <button onClick={togglePaid}>{b.payments.find(p => p.month === month)?.paid ? "Mark Unpaid" : "Mark Paid"}</button>
        </div>

        <div style={{ marginTop: 12 }}>
          <h4>Fees</h4>
          <ul>
            {b.fees.map(f => (
              <li key={f.id} style={{ display: "flex", justifyContent: "space-between" }}>
                <span>{f.name} — ${f.amount.toFixed(2)}</span>
                <button onClick={() => deleteFee(f.id)}>Delete</button>
              </li>
            ))}
          </ul>
          <AddFeeForm onAdd={(n, a) => addFee(n, a)} />
        </div>

        <div style={{ marginTop: 12 }}>
          <button onClick={() => { props.onSave(b); }}>Save</button>
          <button onClick={props.onClose}>Close</button>
        </div>
      </div>
    </div>
  );
}

function AddFeeForm({ onAdd }: { onAdd: (name: string, amount: number) => void }) {
  const [name, setName] = useState("");
  const [amount, setAmount] = useState<number>(0);
  return (
    <div>
      <input placeholder="Fee name" value={name} onChange={e => setName(e.target.value)} />
      <input type="number" placeholder="Amount" value={amount} onChange={e => setAmount(Number(e.target.value))} />
      <button onClick={() => { if (!name) return; onAdd(name, amount); setName(""); setAmount(0); }}>Add Fee</button>
    </div>
  );
}
