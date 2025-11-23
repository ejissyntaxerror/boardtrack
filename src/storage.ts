import { Boarder, ID, YearMonth } from "./types";

const KEY = "boardtrack_v1";

export function uid(prefix = "") {
  return prefix + Math.random().toString(36).slice(2, 9);
}

function nowISO() {
  return new Date().toISOString();
}

export function getMonthKey(date = new Date()) {
  return `${date.getFullYear()}-${String(date.getMonth() + 1).padStart(2, "0")}`;
}

export function loadAll(): Boarder[] {
  try {
    const raw = localStorage.getItem(KEY);
    if (!raw) return [];
    return JSON.parse(raw) as Boarder[];
  } catch {
    return [];
  }
}

export function saveAll(boarders: Boarder[]) {
  localStorage.setItem(KEY, JSON.stringify(boarders));
}

export function addBoarder(data: { name: string; room: string; rent: number }) {
  const boarders = loadAll();
  boarders.push({
    id: uid("b_"),
    name: data.name,
    room: data.room,
    rent: data.rent,
    fees: [],
    payments: [],
    createdAt: nowISO()
  });
  saveAll(boarders);
  return boarders;
}

export function updateBoarder(updated: Boarder) {
  const boarders = loadAll().map(b => (b.id === updated.id ? updated : b));
  saveAll(boarders);
  return boarders;
}

export function deleteBoarder(id: ID) {
  const boarders = loadAll().filter(b => b.id !== id);
  saveAll(boarders);
  return boarders;
}

export function forMonth(boarders: Boarder[], month: YearMonth) {
  // return a shallow map with payments and fees relevant to month
  return boarders.map(b => {
    const payment = b.payments.find(p => p.month === month);
    const unpaidFees = b.fees.filter(f => f.createdAt.slice(0, 7) === month);
    return { boarder: b, paid: payment?.paid ?? false, feesThisMonth: unpaidFees };
  });
}
