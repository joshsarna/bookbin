/* global Vue, VueRouter, axios */

var BooksShow = {
  template: '#books-show',
  data: function() {
    return {
      message: null,
      book: {},
      picked: "",
      recommendation: false
    };
  },
  computed: {},
  created: function() {
    $( ".modal-backdrop" ).remove();
    if ( this.$route.query.recommendation === "true") {
      this.recommendation = true;
    }
    if (this.$route.params.id === '0') {
      this.message = "Sorry, we need more data before we can make a recommendation. Please review more books.";
    } else {
      axios.get('/api/books/' + this.$route.params.id).then(function(response) {
        this.book = response.data;
      }.bind(this));
    }
  },
  methods: {
    addBookReview: function() {
      let worthReading = this.picked === "worthReading" ? true : false;
      axios.post('/api/reviews', {book: this.book.title, worth_reading: worthReading}).then(function(response) {
        router.push("/");
      });
    }
  }
};

var LogoutPage = {
  template: "<h1>Logout</h1>",
  created: function() {
    axios.defaults.headers.common["Ring"] = undefined;
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
          axios.defaults.headers.common["Ring"] =
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
      books: [],
      reviews: [],
      book: "",
      picked: "",
      authorUpdated: "",
      imageUrlUpdated: "",
      moreInfoNeeded: false
    };
  },

  computed: {
    lastBook: function() {
      return this.reviews[this.reviews.length - 1].book;
    }
  },

  created: function() {
    if (!localStorage.getItem("jwt")) {
      router.push('/login');
    } else {
      axios.defaults.headers.common["Ring"] =
            "Bearer " + localStorage.getItem("jwt");
    }

    axios.get('/api/reviews').then(function(response) {
      this.reviews = response.data;
    }.bind(this));
    axios.get('/api/books').then(function(response) {
      this.books = response.data;
    }.bind(this));
  },

  methods: {
    addBookReview: function() {
      let worthReading = this.picked === "worthReading" ? true : false;
      axios.post('/api/reviews', {book: this.book, worth_reading: worthReading}).then(function(response) {
        this.books.push(response.data);
        // console.log(response.data);
        this.reviews.push(response.data);
        if (response.data.book.author === null) {
          this.moreInfoNeeded = true;
        } else {
          this.picked = "";
          this.book = "";
        }
      }.bind(this));
    },
    updateLastBook: function() {
      let book = this.lastBook;
      let params = {
        author: this.authorUpdated,
        image_url: this.imageUrlUpdated
      };
      // console.log(params);
      // console.log(book.id);
      axios.patch('/api/books/' + book.id, params).then(function(response) {
        // console.log(response.data);
        this.moreInfoNeeded = false;
        router.push('/books/' + book.id);
      }.bind(this));
    },
    getRecommendation: function() {
      $('#loadingModal').modal('toggle');
      axios.get('/api/books/recommendation').then(function(response) {
        router.push('/books/' + response.data.id + '?recommendation=true');
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