import React, { useEffect, useState } from "react";
import { loadAll, saveAll, addBoarder, updateBoarder, getMonthKey, forMonth } from "./storage";
import { Boarder } from "./types";
import Dashboard from "./components/Dashboard";
import AddBoarder from "./components/AddBoarder";
import BoarderProfile from "./components/BoarderProfile";
import MonthlySummary from "./components/MonthlySummary";

export default function App() {
  const [boarders, setBoarders] = useState<Boarder[]>([]);
  const [filterMonth, setFilterMonth] = useState<string>(getMonthKey());
  const [adding, setAdding] = useState(false);
  const [selected, setSelected] = useState<Boarder | null>(null);
  useEffect(() => setBoarders(loadAll()), []);
  function refresh() { setBoarders(loadAll()); }
  function handleAdd(data: { name: string; room: string; rent: number }, addAnother?: boolean) {
    addBoarder(data);
    refresh();
    if (!addAnother) setAdding(false);
  }
  function handleUpdate(b: Boarder) { updateBoarder(b); refresh(); setSelected(null); }
  return (
    <div style={{ padding: 16, fontFamily: "sans-serif" }}>
      <h1>BoardTrack</h1>
      <Dashboard
        boarders={boarders}
        month={filterMonth}
        onChangeMonth={m => setFilterMonth(m)}
        onAdd={() => setAdding(true)}
        onSelect={b => setSelected(b)}
      />
      {adding && <AddBoarder onSave={handleAdd} onClose={() => setAdding(false)} />}
      {selected && <BoarderProfile boarder={selected} onSave={handleUpdate} onClose={() => setSelected(null)} />}
      <MonthlySummary boarders={boarders} month={filterMonth} onExport={data => {
        const blob = new Blob([JSON.stringify(data, null, 2)], { type: "application/json" });
        const url = URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.href = url; a.download = `boardtrack_${filterMonth}.json`; a.click();
        URL.revokeObjectURL(url);
      }} />
    </div>
  );
}
