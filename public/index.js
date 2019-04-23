/* global Vue, VueRouter, axios */

var BooksShow = {
  template: '#books-show',
  data: function() {
    return {
      message: 'Books Show',
      book: {}
    };
  },
  computed: {},
  created: function() {
    axios.get('/api/books/' + this.$route.params.id).then(function(response) {
      this.book = response.data;
    }.bind(this));
  },
  methods: {}
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Authorization"] = undefined;
    localStorage.removeItem("jwt");
    router.push("/");
  }
};

var LoginPage = {
  template: "#login-page",
  data: function() {
    return {
      email: "",
      password: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        email: this.email, password: this.password
      };
      axios
        .post("/api/sessions", params)
        .then(function(response) {
          axios.defaults.headers.common["Authorization"] =
            "Bearer " + response.data.jwt;
          localStorage.setItem("jwt", response.data.jwt);
          router.push("/");
        })
        .catch(
          function(error) {
            this.errors = ["Invalid email or password."];
            this.email = "";
            this.password = "";
          }.bind(this)
        );
    }
  }
};

var SignupPage = {
  template: "#signup-page",
  data: function() {
    return {
      email: "",
      password: "",
      passwordConfirmation: "",
      errors: []
    };
  },
  methods: {
    submit: function() {
      var params = {
        email: this.email,
        password: this.password,
        password_confirmation: this.passwordConfirmation
      };
      axios
        .post("/api/users", params)
        .then(function(response) {
          router.push("/login");
        })
        .catch(
          function(error) {
            this.errors = error.response.data.errors;
          }.bind(this)
        );
    }
  }
};

var HomePage = {
  template: '#home-page',
  data: function() {
    return {
      message: 'Welcome to Vue.js!',
      reviews: [],
      book: "",
      picked: "",
      moreInfoNeeded: false
    };
  },
  computed: {
    lastBook: function() {
      return this.books[this.books.length - 1];
    }
  },
  created: function() {
    axios.get('/api/reviews').then(function(response) {
      this.reviews = response.data;
      console.log(this.reviews);
    }.bind(this));
  },
  methods: {
    addBookReview: function() {
      axios.post('/api/reviews', {book: this.book, worth_reading: this.picked}).then(function(response) {
        this.books.push(response.data);
        if (response.data.author === null) {
          this.moreInfoNeeded = true;
        }
      }.bind(this));
    },
    updateLastBook: function() {
      let book = this.lastBook;
      let params = {
        author: this.lastBook.author,
        image_url: this.lastBook.image_url
      };
      axios.patch('/api/books/' + book.id, params).then(function(response) {
        console.log(response.data);
      });
    },
    getRecommendation: function() {
      axios.get('/api/books/recommendation').then(function(response) {
        router.push('/books/' + response.data.id);
      });
    }
  }
};

var router = new VueRouter({
  routes: [
    { path: '/', component: HomePage },
    { path: "/signup", component: SignupPage },
    { path: "/login", component: LoginPage },
    { path: "/logout", component: LogoutPage },
    { path: "/books/:id", component: BooksShow }
  ],
  scrollBehavior: function(to, from, savedPosition) {
    return { x: 0, y: 0 };
  }
});

var app = new Vue({
  el: '#vue-app',
  router: router
});