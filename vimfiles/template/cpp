/*
 * "%:t"
 *  remarks
 *
 *  written by janus_wel<janus.wel.3@gmail.com>
 *  This source code is in public domain, and has NO WARRANTY.
 * */

#include "../../header/main.hpp"

/*
#include "../../header/algorithm.hpp"
#include "../../header/typeconv.hpp"
*/

#include <iostream>

/*
#include <iomanip>
#include <string>
#include <stdexcept>
#include <locale>
*/

class Main : public util::main::main {
/*
    public:
        static util::string::typeconverter& tconv(void) {
            static util::string::typeconverter tconv;
            return tconv;
        }
*/
/*
    private:
        class opt_version_type : public option_type {
            private:
                bool state;

            public:
                opt_version_type(void) : state(false) {}

            public:
                bool operator()(void) { return state; }

            protected:
                const char_type* shortname(void) const { return "v"; }
                const char_type* longname(void) const { return "version"; }
                unsigned int handle_params(const parameters_type&) {
                    state = true;
                    return 1;
                }
        } opt_version;

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
                        state = Main::tconv().strto<unsigned int>(*next);
                        return 2;
                    }
                    else {
                        throw std::runtime_error("specify size: "
                                + *(params.current()));
                    }
                }
        } opt_size;
*/
/*
    public:
        Main(void) {
            register_option(opt_version);
            register_option(opt_size);
        }
*/

    public:
        int start(void) {
/*
            string_array_type unknown_opt;
            util::algorithm::grep(
                    nonopt_parameters.begin(), nonopt_parameters.end(),
                    unknown_opt, option_type::has_opt_prefix);
            if (!unknown_opt.empty()) {
                throw std::runtime_error("unknown option: "
                        + tconv().join(
                            unknown_opt.begin(),
                            unknown_opt.end(), ", "));
            }

            if (nonopt_parameters.size() > 1) {
                throw std::runtime_error("too many parameters");
            }

            const string_type& input = nonopt_parameters.empty()
                ? std::string()
                : nonopt_parameters[0];

            if (util::main::is_redirected()) {
                std::cout.rdbuf(std::cerr.rdbuf());
            }

            std::cout << std::left << std::boolalpha
                << std::setw(10) << "version"    << opt_version() << "\n"
                << std::setw(10) << "help"       << opt_help() << "\n"
                << std::setw(10) << "size"       << opt_size() << "\n"
                << std::setw(10) << "input"      << input << "\n"
                << std::setw(10) << "output"     << opt_output() << "\n"
                << std::endl;
*/

            return 0;
        }
};

int main(const int argc, const char* const argv[]) {
    try {
//        std::locale::global(std::locale(""));
        Main main;
        main.do_parameters(argc, argv);
        return main.start();
    }
    catch (const std::exception& ex) {
        std::cerr << "error: " << ex.what() << std::endl;
    }
}

