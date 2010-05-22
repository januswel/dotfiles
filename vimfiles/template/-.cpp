/*
 * "%:t"
 *  remarks
 *
 *  written by janus_wel<janus.wel.3@gmail.com>
 *  This source code is in public domain, and has NO WARRANTY.
 * */

#include <iostream>
#include <stdexcept>
#include <list>

/*
#include <iomanip>
#include <string>
#include <locale>
*/

#include "../../header/getopt.hpp"

/*
#include "../../header/event.hpp"
#include "../../header/typeconv.hpp"
*/

// enumerations for return expression
enum return_type {
    OK = 0,
    BAD_ARGUMENT,
    UNKNOWN
};

/*
enum priority_type {
    VERSION,
    HELP,
    UNSPECIFIED
};
*/

// customized exception class
class main_error : public std::domain_error {
    private:
        return_type mv_return_value;

    public:
        main_error(const return_type return_value, const std::string& msg)
            : std::domain_error(msg), mv_return_value(return_value) {}
        return_type return_value(void) const { return mv_return_value; }
};

class Main : public util::getopt::getopt
             /*, public pattern::event::event_listener<priority_type>*/ {
    private:
        // input
        string_type input;
        // unknown options
        std::list<string_type> unknown_opt;
/*
        // a kind of priority action
        // default: UNSPECIFIED
        priority_type priority;
*/

    protected:
        unsigned int handle_unknown_opt(const parameters_type& params) {
            // cash unknown options
            unknown_opt.push_back(*(params.current()));
            return 1;
        }
        unsigned int handle_behind_parameters(const parameters_type& params) {
            // only one input is allowed
            throw main_error(BAD_ARGUMENT,
                      "don't specify anything behind the nonopt parameter: "
                    + *(params.current()));
        }
        unsigned int handle_nonopt(const parameters_type& params) {
            // treat as input
            input = *(params.current());
            return 1;
        }

/*
    public:
        // event handler
        void handle_event(const priority_type& p) {
            if (priority == UNSPECIFIED) priority = p;
        }
*/

    public:
/*
        // utility function
        static util::string::typeconverter& tconv(void) {
            static util::string::typeconverter tconv;
            return tconv;
        }
*/

        // version definition
        static const char* version(void) { return "1.00"; }
        static const char* name(void) { return "sample"; }
        // typical one
        static void usage(std::ostream& out) {
            out
                << "usage\n"
                << std::endl;
        }
        // the another typical
        static void version_license(std::ostream& out) {
            out << name() << " version " << version() << "\n"
                << std::endl;
        }

/*
    private:
        // option definitions
        // example for flag-type option
        class opt_version_type
            : public option_type,
              public pattern::event::event_source<priority_type> {
            protected:
                const char_type* shortname(void) const { return "v"; }
                const char_type* longname(void) const { return "version"; }
                unsigned int handle_params(const parameters_type&) {
                    dispatch_event(VERSION);
                    return 1;
                }
        } opt_version;

        // example for binding-argument[s]-type option
        class opt_size_type : public option_type {
            private:
                unsigned int state;
                static const unsigned int size_default = 4096;

            public:
                opt_size_type(void) : state(size_default) {}

            public:
                unsigned int operator()(void) { return state; }

            protected:
                const char_type* shortname(void) const { return "s"; }
                const char_type* longname(void) const { return "size"; }
                unsigned int handle_params(const parameters_type& params) {
                    parameters_type::const_iterator next =
                        params.current() + 1;
                    if (next != params.end()) {
                        state = tconv().strto<unsigned int>(*next);
                        return 2;
                    }
                    else {
                        throw main_error(BAD_ARGUMENT,
                                "specify size: " + *(params.current()));
                    }
                }
        } opt_size;

    public:
        Main(void) : priority(UNSPECIFIED) {
            // register options
            register_option(opt_version);
            register_option(opt_size);

            opt_version.add_event_listener(this);
        }
*/
    private:
        void preparation(void) {
/*
            if (input.empty()) {
                throw main_error(BAD_ARGUMENT, "specify input");
            }
*/
/*
            if (!unknown_opt.empty()) {
                throw main_error(BAD_ARGUMENT,
                        "unknown options: "
                        + tconv().join(
                            unknown_opt.begin(),
                            unknown_opt.end(), ", "));
            }
*/
        }

    public:
        int start(void) {
            preparation();

/*
            if (priority != UNSPECIFIED) {
                switch (priority) {
                    case VERSION:   version_license(std::cout); break;
                    case HELP:      usage(std::cout);           break;
                    default:        throw std::logic_error("unknown error");
                }
                return OK;
            }
*/
/*
            std::cout << std::left << std::boolalpha
                << std::setw(10) << "size"       << opt_size() << "\n"
                << std::setw(10) << "input"      << input << "\n"
                << std::endl;
*/

            return OK;
        }
};

int main(const int argc, const char* const argv[]) {
    try {
//        std::locale::global(std::locale(""));
        Main main;
        main.analyze_option(argc, argv);
        return main.start();
    }
    catch (const main_error& ex) {
        std::cerr << ex.what() << std::endl;
        if (ex.return_value() == BAD_ARGUMENT) Main::usage(std::cerr);
        return ex.return_value();
    }
    catch (const std::exception& ex) {
        std::cerr << "error: " << ex.what() << std::endl;
        return UNKNOWN;
    }
}

