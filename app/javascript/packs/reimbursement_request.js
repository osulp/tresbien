import { observable, spy } from 'mobx';
import Form from '../reimbursement_request/form'
import Utils from '../utils/utils'

const initialState = observable({
  city_rows: [],
  itinerary_rows: [],
  above_per_diem_rows: [],
  basic_rows: [],
  expense_other_rows: [],
  accounting_rows: [],
  itinerary_days_queue: [],
  above_per_diem_queue: [],
  accounting_rows_queue: [],
  get accountings_total() {
    return this.accounting_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get itineraries_total() {
    return this.itinerary_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get expense_airfare_total() {
    return this.basic_rows.filter(r => r.table_name === 'expense-airfare').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get expense_other_total() {
    let rows_total = this.expense_other_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
    return this.above_per_diem_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0) + rows_total;
  },
  get expense_mileage_total() {
    return this.basic_rows.filter(r => r.table_name === 'expense-mileage').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get grand_total() {
    let itineraries_total = this.itinerary_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
    let above_per_diem_total = this.above_per_diem_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
    let expense_other_total = this.expense_other_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
    return this.basic_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0) + expense_other_total + itineraries_total + above_per_diem_total;
  }
});

let ready = () => {
  // Global spy to log everything that Mobx is doing for dev purposes
  console.log("Ready fired, starting app.");
  spy(e => console.log(e));
  let f = new Form('.reimbursement-request-form', initialState);
};

$(document).ready(ready);
