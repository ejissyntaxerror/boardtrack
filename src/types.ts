export type ID = string;
export type YearMonth = string; // "YYYY-MM"

export interface Fee {
  id: ID;
  name: string;
  amount: number;
  createdAt: string;
}

export interface PaymentRecord {
  month: YearMonth;
  paid: boolean;
  updatedAt: string;
}

export interface Boarder {
  id: ID;
  name: string;
  room: string;
  rent: number;
  fees: Fee[];
  payments: PaymentRecord[]; // one per month toggled
  createdAt: string;
}
