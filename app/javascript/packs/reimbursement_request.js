import { observable, spy } from 'mobx';
import Form from '../reimbursement_request/form'
import Utils from '../utils/utils'

const initialState = observable({
  city_rows: [],
  itinerary_rows: [],
  basic_rows: [],
  itinerary_days_queue: [],
  get itineraries_total() {
    return this.itinerary_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get accounting_total() {
    return this.basic_rows.filter(r => r.table_name === 'accounting').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get expense_airfare_total() {
    return this.basic_rows.filter(r => r.table_name === 'expense-airfare').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get expense_other_total() {
    return this.basic_rows.filter(r => r.table_name === 'expense-other').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get expense_mileage_total() {
    return this.basic_rows.filter(r => r.table_name === 'expense-mileage').map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
  },
  get grand_total() {
    let itineraries_total = this.itinerary_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0);
    return this.basic_rows.map(i => i.row_total).reduce((sum, val) => parseFloat((sum + val).toFixed(2)), 0) + itineraries_total;
  }
});

let ready = () => {
  // Global spy to log everything that Mobx is doing for dev purposes
  console.log("Ready fired, starting app.");
  spy(e => console.log(e));
  let f = new Form('.reimbursement-request-form', initialState);
};

$(document).ready(ready);
