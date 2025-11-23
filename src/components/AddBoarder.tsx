import React, { useState } from "react";

export default function AddBoarder(props: { onSave: (d: { name: string; room: string; rent: number }, addAnother?: boolean) => void; onClose: () => void; }) {
  const [name, setName] = useState("");
  const [room, setRoom] = useState("");
  const [rent, setRent] = useState<number>(0);
  return (
    <div style={{ position: "fixed", inset: 0, background: "rgba(0,0,0,0.3)", display: "flex", alignItems: "center", justifyContent: "center" }}>
      <div style={{ background: "white", padding: 16, width: 320 }}>
        <h3>Add Boarder</h3>
        <div><input placeholder="Name" value={name} onChange={e => setName(e.target.value)} /></div>
        <div><input placeholder="Room" value={room} onChange={e => setRoom(e.target.value)} /></div>
        <div><input type="number" placeholder="Rent" value={rent} onChange={e => setRent(Number(e.target.value))} /></div>
        <div style={{ marginTop: 8 }}>
          <button onClick={() => { props.onSave({ name, room, rent }, false); }}>Save</button>
          <button onClick={() => { props.onSave({ name, room, rent }, true); setName(""); setRoom(""); setRent(0); }}>Save & Add Another</button>
          <button onClick={props.onClose}>Close</button>
        </div>
      </div>
    </div>
  );
}
